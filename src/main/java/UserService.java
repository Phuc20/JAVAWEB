import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
// day la phuong thuc taong dung moi
    public User createUser(String email, String password, String role) {
        String encryptedPassword = passwordEncoder.encode(password);  // o day se ma  hoa mat khau
        User user = new User(email, encryptedPassword, role);
        return userRepository.save(user);  // Luu user  vao csdl
    }
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    // day la phuong thuc de xac thuc user khi login vao
}
