package DAO;

import Model.User;
import Util.HikariCP;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collection;

public class DAO_User implements IDAO<User> {

    public static DAO_User getInstance() {
        return new DAO_User();
    }
    @Override
    public int insert(User user) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            try {
                return handle.execute("INSERT INTO USERS (id, email, password) VALUES (?,?,?)",
                        user.getId(), user.getEmail(), user.getPassword());
            } catch (Exception e) {
                if (e.getCause() instanceof SQLIntegrityConstraintViolationException && e.getMessage().contains("Duplicate entry")) {
                    return -1;
                } else
                    throw e;
            }
        });
    }

    @Override
    public User select(User user) {
        return Jdbi.create(HikariCP.getDataSource())
                .registerRowMapper(User.class, new UserMapper())
                .withHandle(handle -> {
                    return handle.createQuery("SELECT * FROM USERS WHERE ID = ?")
                            .bind(0, user.getId())
                            .mapTo(User.class)
                            .findFirst()
                            .get();
                });
    }

    @Override
    public Collection<User> selectAll() {
        return null;
    }

    @Override
    public int update(User user) {
        return 0;
    }

    @Override
    public int delete(User user) {
        return 0;
    }

    private String findWEmail(String email) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            return handle.createQuery("SELECT ID FROM USERS WHERE EMAIL = ?")
                    .bind(0, email)
                    .mapTo(String.class)
                    .findFirst()
                    .orElse(null); // Trả về null nếu không tìm thấy
        });
    }

    /**
     * Kiểm tra xem email và mật khẩu có khớp với bất kỳ người dùng nào trong cơ sở dữ liệu hay không.
     *
     * @param email    Địa chỉ email của người dùng cần xác thực.
     * @param password Mật khẩu của người dùng cần xác thực.
     * @return ID của người dùng nếu thông tin đăng nhập khớp, nếu không trả về chuỗi rỗng.
     * @throws NullPointerException nếu email hoặc mật khẩu là null.
     * @Ví dụ:
     * <p>
     * * `checkEnP("johndoe@example.com", "password123")` có thể trả về `"1234567890"` nếu người dùng tồn tại với email và mật khẩu đó.
     * * `checkEnP("johndoe@example.com", "wrongpassword")` sẽ trả về chuỗi rỗng vì mật khẩu không chính xác.
     * * `checkEnP("nonexistentuser@example.com", "anypassword")` sẽ trả về chuỗi rỗng vì người dùng không tồn tại.
     * @Lưu ý:
     * <p>
     * * Phương thức này sử dụng BCrypt để so sánh mật khẩu dạng văn bản thuần túy với mật khẩu được băm được lưu trữ trong cơ sở dữ liệu.
     */
    public String checkEnP(String email, String password) {
        String id = findWEmail(email);
        if (id != null) {
            String hashedPassword = Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
                return handle.createQuery("SELECT PASSWORD FROM USERS WHERE ID = ?")
                        .bind(0, id)
                        .mapTo(String.class)
                        .findFirst()
                        .orElse(null);
            });

            if (hashedPassword != null && BCrypt.checkpw(password, hashedPassword)) {
                return id; // Trả về id nếu mật khẩu khớp
            }
        }

        return ""; // Trả về "" nếu không khớp hoặc xảy ra lỗi
    }


    public static void main(String[] args) {
        String email = "khuongvo2105@gmail.com", password = "21052002";
        System.out.println("email: " + email+"\tpassword: "+password);
        String id = DAO_User.getInstance().checkEnP(email, password);
        System.out.println("id: "+id);
    }
}

class UserMapper implements RowMapper<User> {
    @Override
    public User map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new User(rs.getString("Id"),
                rs.getString("Email"),
                rs.getString("Password"),
                rs.getByte("Status"), null);
    }
}
