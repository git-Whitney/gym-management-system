<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String name = (String) session.getAttribute("name");
    // Day-based greeting
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);
    String greet = hour < 12 ? "Good morning" : hour < 17 ? "Good afternoon" : "Good evening";
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dashboard — FitZone</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/css/style3.css">
</head>
<body class="has-bg-image">

<%@ include file="nav.jsp" %>

<div class="page-wrapper">

  <!-- Header -->
  <div class="page-header">
    <div class="greeting"><%= greet %>, <span><%= name != null ? name : "Athlete" %></span> 👋</div>
    <div class="subtext">Ready to crush today's session?</div>
  </div>

  <!-- ── BOOKING REMINDER ── -->
  <%
    java.util.List<java.util.Map<String, String>> todayBookings =
      (java.util.List<java.util.Map<String, String>>) request.getAttribute("todayBookings");
    if (todayBookings != null && !todayBookings.isEmpty()) {
      java.util.Map<String, String> next = todayBookings.get(0);
  %>
  <div class="reminder-card">
    <div class="reminder-icon">⏰</div>
    <div class="reminder-body">
      <strong>Session Reminder</strong>
      <span>You have a session at <b><%= next.get("time") %></b> today — don't miss it!</span>
    </div>
  </div>
  <%
    } else {
  %>
  <div class="reminder-card" style="border-color:rgba(0,198,255,0.25); animation:none;">
    <div class="reminder-icon">📅</div>
    <div class="reminder-body">
      <strong>No Session Today</strong>
      <span>Book a session and keep your streak alive 🔥</span>
    </div>
  </div>
  <% } %>

  <!-- ── QUICK ACTIONS ── -->
  <div class="quick-actions">
    <a href="${pageContext.request.contextPath}/LoadSessions" class="action-card">
      <span class="action-icon">🏋️</span>
      <span class="action-label">Book Session</span>
    </a>
    <a href="payment.jsp" class="action-card">
      <span class="action-icon">💳</span>
      <span class="action-label">Pay Fees</span>
    </a>
    <a href="${pageContext.request.contextPath}/myBookings" class="action-card">
      <span class="action-icon">📋</span>
      <span class="action-label">My Bookings</span>
    </a>
    <a href="${pageContext.request.contextPath}/PaymentHistoryServlet" class="action-card">
      <span class="action-icon">📜</span>
      <span class="action-label">History</span>
    </a>
  </div>

  <!-- ── HEALTH TIPS ── -->
  <div class="tips-section glass-card">
    <h3>💡 Daily Health Tips</h3>
    <div class="tip-card" id="tipCard">
      <span class="tip-emoji" id="tipEmoji">💧</span>
      <span id="tipText">Drink at least 8 glasses of water throughout the day, especially before and after your workout.</span>
    </div>
    <div class="tip-dots" id="tipDots"></div>
  </div>

  <!-- ── RECENT PAYMENTS ── -->
  <div class="section-header">
    <h3>💰 Recent Payments</h3>
    <a href="${pageContext.request.contextPath}/PaymentHistoryServlet">View all →</a>
  </div>

  <%
    java.util.List<com.gym.system.Payment> recentPayments =
      (java.util.List<com.gym.system.Payment>) request.getAttribute("recentPayments");
    if (recentPayments != null && !recentPayments.isEmpty()) {
      for (com.gym.system.Payment p : recentPayments) {
  %>
  <div class="booking-card">
    <div class="booking-row">💰 Amount: <b>KES <%= p.getAmount() %></b></div>
    <div class="booking-row">📅 Date: <%= p.getPaymentDate() %></div>
    <div class="booking-row">Status: <span class="status"><%= p.getStatus() %></span></div>
  </div>
  <%
      }
    } else {
  %>
  <p class="text-muted" style="text-align:center; padding:20px 0;">No payments yet.</p>
  <% } %>

</div><!-- /page-wrapper -->

<script>
const tips = [
  { e: "💧", t: "Drink at least 8 glasses of water throughout the day, especially before and after your workout." },
  { e: "🥗", t: "Fuel your body with whole foods. Aim for protein + complex carbs within 45 minutes post-workout." },
  { e: "😴", t: "Aim for 7–9 hours of sleep. Muscle recovery and growth happens primarily during deep sleep." },
  { e: "🧘", t: "Take 5 minutes to stretch after every session. Flexibility reduces injury risk significantly." },
  { e: "🔥", t: "Consistency beats intensity. 30 minutes every day is better than 3 hours once a week." },
  { e: "🫀", t: "Warm up for at least 5 minutes before lifting. Your joints and heart will thank you." },
];

let current = 0;
const textEl  = document.getElementById('tipText');
const emojiEl = document.getElementById('tipEmoji');
const dotsEl  = document.getElementById('tipDots');

function renderDots() {
  dotsEl.innerHTML = '';
  tips.forEach((_, i) => {
    const d = document.createElement('div');
    d.className = 'tip-dot' + (i === current ? ' active' : '');
    d.addEventListener('click', () => showTip(i));
    dotsEl.appendChild(d);
  });
}

function showTip(idx) {
  current = idx;
  textEl.style.opacity = '0';
  setTimeout(() => {
    textEl.textContent = tips[idx].t;
    emojiEl.textContent = tips[idx].e;
    textEl.style.opacity = '1';
    renderDots();
  }, 200);
}

textEl.style.transition = 'opacity 0.3s';
renderDots();

// Auto-cycle every 6 seconds
setInterval(() => showTip((current + 1) % tips.length), 6000);
document.getElementById('tipCard').addEventListener('click', () => showTip((current + 1) % tips.length));
</script>

</body>
</html>
