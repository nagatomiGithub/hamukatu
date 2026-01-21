package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.MyData;
import dao.Dao; // インポート必須

@WebServlet("/MyDataservlet")
public class MyDataservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Dao dao = new Dao();
        // 決定版のDaoメソッドに合わせる
        List<MyData> mdList = dao.getMyDataList();
        
        request.setAttribute("mdList", mdList);
        request.getRequestDispatcher("./WEB-INF/jsp/mdList.jsp").forward(request, response);
    }
}