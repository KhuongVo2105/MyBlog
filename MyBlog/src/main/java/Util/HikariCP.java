package Util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HikariCP {
    private static final Logger logger = LoggerFactory.getLogger(HikariCP.class);
    private static final HikariConfig config = new HikariConfig();
    private static HikariDataSource ds;

    static {
        logger.info("Khởi tạo slf4j");

        config.setDriverClassName("com.mysql.cj.jdbc.Driver");
        config.setJdbcUrl("jdbc:mysql://localhost:3306/MyBlog");
        config.setUsername("root");
        config.setPassword("");
        config.setMinimumIdle(5);
        config.setMaximumPoolSize(10);
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        ds = new HikariDataSource(config);
    }

    public static HikariDataSource getDataSource() {
        return ds;
    }
}
