package Controller;

import DAO.DAO_Article;
import DAO.DAO_Comment;
import Model.Article;
import Model.Comment;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@MultipartConfig
@WebServlet(name = "Document", urlPatterns = "/document")
public class Document extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action) {
            case "load-more":
                loadMore(req, resp);
                break;
            case "detail":
                detail(req, resp);
                break;
            case "load-same":
                same(req, resp);
                break;
            case "edit":
                edit(req, resp);
                break;
            case "load-comment":
                loadComment(req, resp);
                break;
            case "insert-comment":
                insertComment(req, resp);
                break;
            case "hide-comment":
                hideComment(req, resp);
                break;
            case "searching":
                searching(req, resp);
                break;
        }
    }

    private void searching(HttpServletRequest req, HttpServletResponse resp) {
        String word = req.getParameter("words");
        Set<Article> articles = DAO_Article.getInstance().search(word);
        for (Article article:articles){
            article.setContent(null);
        }
        Gson gson = new Gson();
        String json = gson.toJson(articles);
        PrintWriter out = null;
        try {
            out = new PrintWriter(resp.getOutputStream());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        out.println(json);
        out.close();
    }

    private void hideComment(HttpServletRequest req, HttpServletResponse resp) {
        System.out.println("Hide Comment");
        String comment_id = req.getParameter("comment_id");
        System.out.println("comment_id: " + comment_id);

        boolean error = false; // Initialize error flag

        try {
            int id = Integer.parseInt(comment_id);
            Comment comment = new Comment();
            comment.setId(id);

            if (DAO_Comment.getInstance().delete(comment) <= 0) {
                error = true;
            }
        } catch (NumberFormatException e) {
            error = true;
            e.printStackTrace();
        } catch (Exception e) {
            error = true;
            e.printStackTrace();
        } finally {
            PrintWriter out = null;
            try {
                out = new PrintWriter(resp.getOutputStream());
                out.println(error); // Write true for error, false for success
            } catch (IOException e) {
                throw new RuntimeException(e);
            } finally {
                if (out != null) {
                    out.close();
                }
            }
        }

        System.out.println("Finish");
    }

    private void insertComment(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        System.out.println("Insert Comment");
        String article_id = req.getParameter("article_id"),
                email = req.getParameter("email"),
                cmt = req.getParameter("comment");
        boolean error = false;

        Comment comment = new Comment();
        comment.setEmail(email);
        comment.setArticle_id(article_id);
        comment.setComment(cmt);
        if (DAO_Comment.getInstance().insert(comment) <= 0) {
            error = true;
        }
        PrintWriter out = new PrintWriter(resp.getOutputStream());
        out.println(!error);
        out.close();
        System.out.println("Finish");
    }

    private void loadComment(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String content_id = req.getParameter("content_id");
        System.out.println(content_id);
        List<Comment> comments = new ArrayList<>();
        try {
            comments = (List<Comment>) DAO_Comment.getInstance().selectAllByArticleId(Integer.parseInt(req.getParameter("content_id")));
        } catch (NumberFormatException e) {
            throw new RuntimeException(e);
        }
        PrintWriter out = new PrintWriter(resp.getOutputStream());
        out.print(new Gson().toJson(comments));
        out.close();
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("content_id");
        Article article = null;

        if (id != null || !id.isEmpty()) {
            article = new Article();
            article.setId(Integer.parseInt(id));
            article = DAO_Article.getInstance().select(article);
        }

        req.setAttribute("article", article);
        getServletContext().getRequestDispatcher("/Create.jsp").forward(req, resp);
    }

    private void same(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String topic = req.getParameter("topic");
        int offset = 0, limit = 5;
//        if (topic.isEmpty() || topic == null) {
//
//        } else {
//
//        }
        List<Article> articles = (List<Article>) DAO_Article.getInstance().selectAllByTopic(offset, limit);
        for (Article article : articles) {
            article.setContent(null);
            article.setAuthor(null);
            article.setTime(null);
        }
        System.out.println("articles: " + articles.toString());
        Gson gson = new Gson();
        String json = gson.toJson(articles);
        System.out.println(json);
        PrintWriter out = new PrintWriter(resp.getOutputStream());
        out.print(json);
        out.close();
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String content_id = req.getParameter("content_id");
        // TODO: Load detail
        System.out.println("id: " + content_id);
        if (content_id != null || !content_id.isEmpty()) {
            Article article = new Article();
            article.setId(Integer.parseInt(content_id));

            if ((article = DAO_Article.getInstance().select(article)) != null) {
                System.out.println(article.getId() + "");
                req.setAttribute("author", article.getAuthor());
                req.setAttribute("time", article.getTime());
                req.setAttribute("title", article.getTitle());
                req.setAttribute("content", article.getContent());
                req.setAttribute("id", article.getId());

                getServletContext().getRequestDispatcher("/Detail.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    private void loadMore(HttpServletRequest req, HttpServletResponse resp) {
        String offset = req.getParameter("offset"), limit = req.getParameter("limit");
        int count = (offset == null || offset.isEmpty()) ? 0 : Integer.parseInt(offset);
        int lmt = (limit == null || limit.isEmpty()) ? 6 : Integer.parseInt(limit);

        // TODO: Load more
        // Add your code here to load more data from the database and return it in the response
        List<Article> articles = (List<Article>) DAO_Article.getInstance().selectAllByTopic(count, lmt);
        for (Article article : articles) {
            article.setContent(null);
            article.setAuthor(null);
        }
        Gson gson = new Gson();
        String json = gson.toJson(articles);
        PrintWriter out = null;
        try {
            out = new PrintWriter(resp.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
        out.print(json);
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        switch (action) {
            case "post":
                post(req, resp);
                break;
            case "update":
                update(req, resp);
                break;
        }
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String content_id = req.getParameter("id"),
                content = req.getParameter("content"),
                title = req.getParameter("title"),
                thumbnail = req.getParameter("thumbnail");
        boolean error = false;
        // processing
        Article article = new Article();
        try {
            article.setId(Integer.parseInt(content_id));
        } catch (NumberFormatException e) {
            error = true;
            e.printStackTrace();
        }
        article = DAO_Article.getInstance().select(article);
        if (article == null) {
            error = true;
            System.out.println("Article not found");
        } else {
            article.setContent(content);
            article.setTitle(title);
            article.setTime(new Timestamp(System.currentTimeMillis()));
            if (thumbnail != null && !thumbnail.isEmpty()) {
                article.setThumbnail(thumbnail);
            }
            if (DAO_Article.getInstance().update(article) > 0) {
                System.out.println("Update success");
            } else {
                error = true;
                System.out.println("Update fail");
            }
        }

        if (error) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Update failed. Please try again in a few minutes.");
            return;
        }
        getServletContext().getRequestDispatcher("/Blog.jsp").forward(req, resp);
    }

    private void post(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        // 1. Nhận chuỗi String từ tinymce
        String content = req.getParameter("content"),
                title = req.getParameter("title");

        System.out.println("Content: " + content);

        Article article = new Article();
        article.setTitle(title);
        article.setContent(content);
        if (DAO_Article.getInstance().insert(article) > 0) {
            System.out.println("Insert success");
        } else {
            System.out.println("Insert fail");
        }

        getServletContext().getRequestDispatcher("/Blog.jsp").forward(req, resp);
    }
}
