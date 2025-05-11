import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
// day se la trang dki
    @GetMapping("/Register")
    public String showRegistrationForm() {
        return "Register";  // chuyen den trang Register.jsp
    }
// o day se xu ly dki user
    @PostMapping("/Register")
    public String registerUser(@RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String role) {
        // o day se goi userService de tao user va luu vao csdl
        userService.createUser(email, password, role);  // Đang ky user moi
        return "redirect:/Login";  //Dang ky xong thi se chuyen den trang login
    }

    @GetMapping("/Login")
    public String showLoginPage() {
        return "Login";  // chuyen den trang Login.jsp
    }
}
