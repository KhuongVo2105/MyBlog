package DAO;

import Model.Article;
import Util.HikariCP;
import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.core.mapper.RowMapper;
import org.jdbi.v3.core.statement.StatementContext;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;

public class DAO_Article implements IDAO<Article> {
    public static DAO_Article getInstance() {
        return new DAO_Article();
    }

    @Override
    public int insert(Article article) {
        return Jdbi.create(HikariCP.getDataSource()).withHandle(handle -> {
            if (article.getThumbnail() == null || article.getThumbnail().isEmpty()) {
                return handle.execute("INSERT INTO ARTICLES (title, content) VALUES (?,?)",
                        article.getTitle(),
                        article.getContent());
            } else {
                return handle.execute("INSERT INTO ARTICLES (title, content, thumbnail) VALUES (?,?,?)",
                        article.getTitle(),
                        article.getContent(),
                        article.getThumbnail());
            }
        });
    }

    @Override
    public Article select(Article article) {
        return Jdbi.create(HikariCP.getDataSource())
                .registerRowMapper(Article.class, new ArticleMapper())
                .withHandle(handle -> {
                    return handle.createQuery("SELECT * FROM ARTICLES WHERE ID = ?")
                            .bind(0, article.getId())
                            .mapTo(Article.class)
                            .findFirst()
                            .get();
                });
    }

    @Override
    public Collection<Article> selectAll() {
        return null;
    }

    @Override
    public int update(Article article) {
        return 0;
    }

    @Override
    public int delete(Article article) {
        return 0;
    }

    public Collection<Article> selectAllByTopic(int offset, int limit) {
        return Jdbi.create(HikariCP.getDataSource())
                .registerRowMapper(Article.class, new ArticleMapper())
                .withHandle(handle -> {
                    return handle.createQuery("SELECT * FROM ARTICLES ORDER BY Time LIMIT ? OFFSET ?")
                            .bind(0, limit)
                            .bind(1, offset)
                            .mapTo(Article.class)
                            .list();
                });
    }
}

class ArticleMapper implements RowMapper<Article> {

    @Override
    public Article map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Article(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("content"),
                rs.getString("thumbnail"),
                rs.getTimestamp("time"),
                rs.getString("author")
        );
    }
}
