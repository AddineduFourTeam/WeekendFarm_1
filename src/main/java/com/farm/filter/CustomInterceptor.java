package com.farm.filter;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

public class CustomInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        session.setAttribute("isLoggedIn",true);
        String requestURI = request.getRequestURI();

        // 세션에 로그인 정보가 있는지 확인
        boolean isLoggedIn = session.getAttribute("loginUser") != null && (Boolean) session.getAttribute("isLoggedIn");

        // 로그인 페이지 및 루트 페이지 요청인 경우는 허용
        if (requestURI.equals("/") || requestURI.startsWith("/login") || requestURI.startsWith("/join") || requestURI.startsWith("/idCheck")
                || requestURI.startsWith("/list") || requestURI.startsWith("/board") || requestURI.startsWith("/story")
                || requestURI.startsWith("/memInsert") || requestURI.startsWith("/forgotPass") || requestURI.startsWith("/forgotPassCheck")
                || requestURI.startsWith("/completePass") || requestURI.startsWith("/cancelComplete") || requestURI.startsWith("/api/coordinates")) {
            return true;
        }
        // 로그인한 사용자일 경우 페이지 이동 허용
        if (isLoggedIn) {
            return true;
        } else {
            // 로그인하지 않은 사용자일 경우 현재 페이지의 URL을 세션에 저장하여 로그인 후 리다이렉션 시 사용
            session.setAttribute("redirectUrl", requestURI);
            // 로그인 페이지로 리다이렉션
            response.sendRedirect("/login");
            return false;
        }
    }
}