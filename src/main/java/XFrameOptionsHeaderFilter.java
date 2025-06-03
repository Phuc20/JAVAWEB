import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.springframework.stereotype.Component;

@Component
public class XFrameOptionsHeaderFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse res = (HttpServletResponse) response;
        // Xóa hoặc thay đổi header X-Frame-Options
        res.setHeader("X-Frame-Options", "ALLOWALL");
        chain.doFilter(request, response);
    }
}
