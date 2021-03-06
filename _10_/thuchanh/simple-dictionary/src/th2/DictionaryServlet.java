package th2;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "DictionaryServlet",urlPatterns = "/dictionary_servlet")
public class DictionaryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String a=request.getParameter("input_keyword");
        
        Map<String, String> dic = new HashMap<>();
        dic.put("hello", "Xin chào");
        dic.put("how", "Thế nào");
        dic.put("book", "Quyển vở");
        dic.put("computer", "Máy tính");

        String b=null;
       if(dic.containsKey(a)) {
           b=dic.get(a);
       }
       else {
           b="không tìm thấy trong từ điển này";
       }
       request.setAttribute("ok",b);
       request.getRequestDispatcher("result.jsp").forward(request,response);

    }
}
