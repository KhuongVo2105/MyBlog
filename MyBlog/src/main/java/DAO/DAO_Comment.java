package DAO;

import Model.Comment;
import Util.HikariCP;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collection;

public class DAO_Comment implements IDAO<Comment> {
    public static DAO_Comment getInstance() {
        return new DAO_Comment();
    }

    @Override
    public int insert(Comment comment) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            try {
                return handle.execute("INSERT INTO COMMENTS (email, comment, article_id) VALUES (?, ?, ?)", comment.getEmail(), comment.getComment(), comment.getArticle_id());
            } catch (Exception e) {
                if (e instanceof SQLIntegrityConstraintViolationException) {
                    return -1;
                }
                throw e;
            }
        });

    }

    @Override
    public Comment select(Comment comment) {
        return Jdbi.create(HikariCP.getDataSource())
                .registerRowMapper(Comment.class, new CommentMapper())
                .withHandle(handle -> {
                            return handle.createQuery("SELECT * FROM COMMENTS WHERE id = ?")
                                    .bind(0, comment.getId())
                                    .mapTo(Comment.class)
                                    .findFirst()
                                    .get();
                        }
                );
    }

    @Override
    public Collection<Comment> selectAll() {
        return null;
    }

    @Override
    public int update(Comment comment) {
        return 0;
    }

    @Override
    public int delete(Comment comment) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            return handle.execute("UPDATE COMMENTS SET status = 0 WHERE id = ?", comment.getId());
        });
    }

    public Collection<Comment> selectAllByArticleId(int article_id) {
        return Jdbi.create(HikariCP.getDataSource())
                .registerRowMapper(Comment.class, new CommentMapper())
                .withHandle(handle -> {
            return handle.createQuery("SELECT * FROM COMMENTS WHERE article_id = ? ORDER BY time DESC")
                    .bind(0, article_id)
                    .mapTo(Comment.class)
                    .list();
        });
    }

    public static void main(String[] args) {
        Comment cmt1 = new Comment();

    }
}

class CommentMapper implements RowMapper<Comment> {
    @Override
    public Comment map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Comment(
                rs.getInt("id"),
                rs.getString("email"),
                rs.getString("comment"),
                rs.getTimestamp("time"),
                rs.getByte("status"),
                rs.getString("article_id")
        );
    }
}
