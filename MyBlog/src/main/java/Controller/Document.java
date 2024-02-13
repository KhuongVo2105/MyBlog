package Controller;

import DAO.DAO_Article;
import Model.Article;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

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
        }
    }

    private void detail(HttpServletRequest req, HttpServletResponse resp) {
        String content_id = req.getParameter("content_id");
        // TODO: Load detail
    }

    private void loadMore(HttpServletRequest req, HttpServletResponse resp) {
        String offset = req.getParameter("offset");
        int count = (offset == null || offset.isEmpty()) ? 0 : Integer.parseInt(offset);

        // TODO: Load more
        // Add your code here to load more data from the database and return it in the response

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
        // 1. Nhận chuỗi String từ tinymce
        String content = req.getParameter("content");

//        // 2. Lưu chuỗi String vào file 1.html trong thư mục Resources
//        String filePath = getServletContext().getRealPath("/Resources/" + System.currentTimeMillis() + ".html");
//        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
//            writer.write(content);
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }

        Article article = new Article();
        article.setContent(content);
        if (DAO_Article.getInstance().insert(article)>0) {
            System.out.println("Insert success");
        }else {
            System.out.println("Insert fail");
        }

        // 3. Gửi phản hồi thành công
//        resp.setContentType("text/html");
//        resp.getWriter().println("File 1.html đã được lưu thành công!");
//        System.out.println(filePath);
        getServletContext().getRequestDispatcher("/Blog.jsp").forward(req, resp);
    }
}
