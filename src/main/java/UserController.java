import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/users")  // duong dan chung cho cac yeu cau user
public class UserController {

    @Autowired
    private UserService userService;

    // Trang Login
    @GetMapping("/Register")
    public String registerUser(@RequestParam String email, @RequestParam String password, @RequestParam String role) {
        // tao user moi
        User user = userService.createUser(email, password, role);
        return "redirect:/users/Login";  // o day se chuyen huong denn  trang Login.jsp
    }

    // Trang login
    @GetMapping("/Login")
    public String loginUser() {
        return "Login";  // Tra ve trang Login.jsp 
    }
}


