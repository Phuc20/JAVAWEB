
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // Home-  admin se log vao thang
    @GetMapping("/Home")
    public String home() {
        return "Home";  // chuyen den trang Home.jsp
    }
}
