import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    // Tao user moi
    public User createUser(String email, String password, String role) {
        User user = new User(email, password, role);
        return userRepository.save(user);  // Luu user vao csdl
    }

    // tim user theo email
    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email);      // tim user theo email

    }
}
