<%-- nav.jsp  — include this on every page --%>
<%@ page contentType="text/html;charset=UTF-8" %>

<!-- ══ HAMBURGER ══ -->
<button class="hamburger" id="hamburger" aria-label="Menu">
  <span></span><span></span><span></span>
</button>

<!-- ══ OVERLAY ══ -->
<div class="sidebar-overlay" id="overlay"></div>

<!-- ══ SIDEBAR ══ -->
<aside class="sidebar" id="sidebar">

  <div class="sidebar-brand">
    <div class="logo-mark">FIT<span>ZONE</span></div>
    <p>Premium Gym Management</p>
  </div>

  <div class="sidebar-section-label">Navigation</div>

  <nav>
    <%
      String currentPage = request.getServletPath();
      if (currentPage == null) currentPage = "";
    %>

    <!-- Profile — always first -->
    <a href="${pageContext.request.contextPath}/frontend/profile.jsp"
       class="nav-link <%= currentPage.contains("profile") ? "active" : "" %>">
      <span class="icon">👤</span> My Profile
    </a>

    <a href="${pageContext.request.contextPath}/frontend/dashboard.jsp"
       class="nav-link <%= currentPage.contains("dashboard") ? "active" : "" %>">
      <span class="icon">🏠</span> Dashboard
    </a>

    <a href="${pageContext.request.contextPath}/LoadSessions"
       class="nav-link <%= currentPage.contains("booking") ? "active" : "" %>">
      <span class="icon">📅</span> Book a Session
    </a>

    <a href="${pageContext.request.contextPath}/myBookings"
       class="nav-link <%= currentPage.contains("mybooking") ? "active" : "" %>">
      <span class="icon">📋</span> My Bookings
    </a>

    <a href="${pageContext.request.contextPath}/frontend/payment.jsp"
       class="nav-link <%= currentPage.contains("payment") && !currentPage.contains("history") ? "active" : "" %>">
      <span class="icon">💳</span> Make Payment
    </a>

    <a href="${pageContext.request.contextPath}/PaymentHistoryServlet"
       class="nav-link <%= currentPage.contains("payment_history") ? "active" : "" %>">
      <span class="icon">📜</span> Payment History
    </a>

    <div style="height:1px; background:rgba(255,255,255,0.08); margin:10px 0;"></div>

    <a href="${pageContext.request.contextPath}/frontend/login.jsp"
       class="nav-link">
      <span class="icon">🚪</span> Logout
    </a>
  </nav>

  <!-- About the Developer — always last -->
  <div class="sidebar-footer">
    <div class="dev-card">
      <div class="dev-avatar">💻</div>
      <strong>Built by San</strong>
      <p>Full-Stack Developer<br>Java · JSP · MySQL</p>
      <div class="dev-socials">
        <a href="mailto:dev@example.com">✉ Email</a>
        <a href="https://github.com" target="_blank">⌘ GitHub</a>
      </div>
    </div>
  </div>

</aside>

<script>
(function() {
  var btn = document.getElementById('hamburger');
  var sidebar = document.getElementById('sidebar');
  var overlay = document.getElementById('overlay');

  function open() {
    sidebar.classList.add('open');
    overlay.classList.add('visible');
    btn.classList.add('open');
    document.body.style.overflow = 'hidden';
  }
  function close() {
    sidebar.classList.remove('open');
    overlay.classList.remove('visible');
    btn.classList.remove('open');
    document.body.style.overflow = '';
  }

  btn.addEventListener('click', function() {
    sidebar.classList.contains('open') ? close() : open();
  });
  overlay.addEventListener('click', close);

  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') close();
  });
})();
</script>
