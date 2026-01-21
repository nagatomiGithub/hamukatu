package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.Dao;

@WebServlet("/DislikeServlet")
public class DislikeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = (String) request.getSession().getAttribute("userId");
        String idStr = request.getParameter("id");

        if (userId != null && idStr != null) {
            int articleId = Integer.parseInt(idStr);
            new Dao().addDislike(articleId, userId);
        }

        // 記事一覧へ戻す
        response.sendRedirect("ArticleListServlet");
    }
}
