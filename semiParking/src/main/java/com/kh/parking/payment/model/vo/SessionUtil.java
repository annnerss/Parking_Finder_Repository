package com.kh.parking.payment.model.vo;
import java.util.Objects;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

public class SessionUtil {
	public static void addAttribute(String name, Object value) {
        Objects.requireNonNull(RequestContextHolder.getRequestAttributes())
                .setAttribute(name, value, RequestAttributes.SCOPE_SESSION);
    }

    public static Object getAttribute(String name) {
        return Objects.requireNonNull(RequestContextHolder.getRequestAttributes())
                .getAttribute(name, RequestAttributes.SCOPE_SESSION);
    }
    
    public static int getIntAttribute(String name) {
        return (int) getAttribute(name);
    }

    public static String getStringAttribute(String name) {
        return (String) getAttribute(name);
    }
}
