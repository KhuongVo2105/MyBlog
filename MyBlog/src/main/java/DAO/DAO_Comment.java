package DAO;

import Model.Comment;
import Util.HikariCP;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Collection;

public class DAO_Comment implements IDAO<Comment> {
    @Override
    public int insert(Comment comment) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            try {
                return handle.execute("" +
                        "CREATE PROCEDURE insert_comment (\n" +
                        "    IN email VARCHAR(255),\n" +
                        "    IN comment TEXT,\n" +
                        "    IN time DATETIME,\n" +
                        "    IN status TINYINT,\n" +
                        "    IN article_id INT\n" +
                        ")\n" +
                        "BEGIN\n" +
                        "    DECLARE new_id INT;\n" +
                        "\n" +
                        "    INSERT INTO COMMENTS (email, comment, article_id)\n" +
                        "    VALUES (?,?,?)\n" +
                        "    ON DUPLICATE KEY UPDATE\n" +
                        "        email = email,\n" +
                        "        comment = comment,\n" +
                        "        time = time,\n" +
                        "        status = status,\n" +
                        "        article_id = article_id;\n" +
                        "\n" +
                        "    IF @@ROW_COUNT = 0 THEN\n" +
                        "        SET new_id = LAST_INSERT_ID();\n" +
                        "    ELSE\n" +
                        "        SET new_id = (SELECT id FROM COMMENTS WHERE email = email AND comment = comment AND time = time AND status = status AND article_id = article_id);\n" +
                        "    END IF;\n" +
                        "\n" +
                        "    SELECT new_id;\n" +
                        "END;\n" +
                        "", comment.getEmail(), comment.getComment(), comment.getArticle_id());
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
        return null;
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
        return 0;
    }


    public static void main(String[] args) {
        Comment cmt1 = new Comment();

    }
}
