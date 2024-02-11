package Controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    private void post(HttpServletRequest req, HttpServletResponse resp) {
        String content = req.getParameter("content");
        // TODO: Post
        System.out.println("content: " + content);
    }
}
