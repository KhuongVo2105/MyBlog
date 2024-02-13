package DAO;

import Model.Social;
import Util.HikariCP;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.stream.Collectors;

public class DAO_Social implements IDAO<Social> {
    @Override
    public int insert(Social social) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            try {
                return handle.execute("INSERT INTO SOCIALS (user_id, social_name, link) VALUES (?,?,?)",
                        social.getUser_id(),
                        social.getSocial_name(),
                        social.getLink());
            } catch (Exception e) {
                if (e instanceof SQLIntegrityConstraintViolationException) {
                    return -1;
                }
                throw e;
            }
        });
    }

    @Override
    public Social select(Social social) {
        return Jdbi.create(HikariCP.getDataSource())
                .registerRowMapper(Social.class, new SocialMapper())
                .withHandle(handle -> {
                    return handle.createQuery("SELECT * FROM SOCIALS WHERE ID = ?")
                            .bind(0, social.getId())
                            .mapTo(Social.class)
                            .findFirst()
                            .get();
                });
    }

    @Override
    public Collection<Social> selectAll() {
        return null;
    }

    @Override
    public int update(Social social) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            return handle.execute("UPDATE SOCIALS SET social_name = ?, link = ? WHERE id = ?",
                    social.getId(),
                    social.getSocial_name(),
                    social.getLink());
        });
    }

    @Override
    public int delete(Social social) {
        return 0;
    }

    public Collection<Social> selectByUser(String user_id) {
        return Jdbi.create(HikariCP.getDataSource())
                .withHandle(handle -> {
                    // Thay thế "SELECT *" với câu truy vấn phù hợp
                    return handle.createQuery("SELECT * FROM SOCIAL WHERE USER_ID = ?")
                            .bind(0, user_id)
                            // Đăng ký mapper cho class Social
                            .mapTo(Social.class)
                            // Sử dụng collector đã đăng ký
                            .collect(Collectors.toCollection(LinkedHashSet::new));
                });
    }

    public static void main(String[] args) {

        DAO_Social dao = new DAO_Social();
        Social social = new Social();
        social.setUser_id("036c5043-f22c-4446-8ab0-35889b21de09");
        social.setSocial_name("Facebook");
        social.setLink("https://www.facebook.com/");
        System.out.println(new DAO_Social().insert(social));
    }

}

class SocialMapper implements RowMapper<Social> {
    @Override
    public Social map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Social(rs.getInt("id"),
                rs.getString("user_id"),
                rs.getString("social_name"),
                rs.getString("link"));
    }
}
