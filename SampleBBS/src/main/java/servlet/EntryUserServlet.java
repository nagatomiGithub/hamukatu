package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// --- 必須のインポート ---
import beans.User;
import dao.Dao;

@WebServlet("/EntryUserServlet")
public class EntryUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");

        Dao dao = new Dao();
        // IDが未登録かつパスワードが一致する場合のみ登録
        if (id != null && !id.isBlank() 
                && dao.getUserById(id) == null 
                && password1 != null && password1.equals(password2)
                && !password1.isBlank()) {
            
            User userToEntry = new User(id, password1, name);
            dao.insertUser(userToEntry);
            request.getRequestDispatcher("./WEB-INF/jsp/login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("./WEB-INF/jsp/entryUser.jsp").forward(request, response);
        }
    }
}