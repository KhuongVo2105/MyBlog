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
            return handle.execute("INSERT INTO ARTICLES (content, thumbnail) VALUES (?,?)",
                    article.getContent(),
                    article.getThumbnail());
        });
    }

    @Override
    public Article select(Article article) {
        return null;
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
}

class ArticleMapper implements RowMapper<Article> {

    @Override
    public Article map(ResultSet rs, StatementContext ctx) throws SQLException {
        return new Article(
                rs.getInt("id"),
                rs.getString("content"),
                rs.getString("thumbnail")
        );
    }
}
