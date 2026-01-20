package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Article;
import dao.Dao;

@WebServlet("/ArticleListServlet")
public class ArticleListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String keyword = request.getParameter("searchKeyword");
        boolean isTrend = "true".equals(request.getParameter("trend"));
        
        Dao dao = new Dao();
        List<Article> articleList = dao.getArticleList(keyword, isTrend);

        request.setAttribute("articleList", articleList);
        request.getRequestDispatcher("./WEB-INF/jsp/articleList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}