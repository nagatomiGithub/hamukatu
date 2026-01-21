package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;

@WebServlet("/DeleteCommentServlet")
public class DeleteCommentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String userId = (String) req.getSession().getAttribute("userId");
        String idStr = req.getParameter("commentId");

        if (userId != null && idStr != null) {
            try {
                int commentId = Integer.parseInt(idStr);
                new Dao().deleteComment(commentId, userId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/ArticleListServlet");
    }
}
