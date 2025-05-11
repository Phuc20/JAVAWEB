import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/Login", "/Register").permitAll()  // Cho phep truy cap vao trang Login and Register cho tat ca cac role
                .antMatchers("/Home").hasRole("ADMIN")// duy nhat admin truy cap
                .anyRequest().authenticated()  // Yêu cầu xác thực cho tất cả các yêu cầu còn lại
                .and()
                .formLogin()
                .loginPage("/Login")  // Chi dinh trang dang nhap
                .permitAll()
                .and()
                .logout()
                .permitAll();  // Cho phep logout
    }
}
