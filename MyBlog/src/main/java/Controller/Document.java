package Controller;

import DAO.DAO_Article;
import Model.Article;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
        }
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
        }
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
