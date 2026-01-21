package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.User;
import dao.Dao;

@WebServlet("/EntryUserServlet")
public class EntryUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String password1 = request.getParameter("password1");
        String password2 = request.getParameter("password2");

        // --- 入力チェック（仕様：半角英数字）---
        if (id == null || id.isBlank() || id.length() > 64 || !id.matches("^[0-9A-Za-z]+$")) {
            request.setAttribute("error", "ログインIDは半角英数字（最大64文字）で入力してください。");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }
        if (name == null || name.isBlank()) {
            request.setAttribute("error", "氏名を入力してください。");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }
        if (password1 == null || password1.isBlank() || !password1.matches("^[0-9A-Za-z]+$")) {
            request.setAttribute("error", "パスワードは半角英数字で入力してください。");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }
        if (!password1.equals(password2)) {
            request.setAttribute("error", "パスワードが一致しません。");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }

        Dao dao = new Dao();

        // ID重複チェック
        if (dao.getUserById(id) != null) {
            request.setAttribute("error", "そのログインIDは既に使われています。");
            request.getRequestDispatcher("/WEB-INF/jsp/entryUser.jsp").forward(request, response);
            return;
        }

        // 登録
        User userToEntry = new User(id, password1, name);
        dao.insertUser(userToEntry);

        // 成功 → ログイン画面へ
        request.setAttribute("info", "登録が完了しました。ログインしてください。");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }
}
