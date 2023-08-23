import consumer from "./consumer";
$(document).ready(function () {
  var notificationCount = parseInt($("#notification-count").text());
  if (notificationCount === 1) {
    $("#readbtn").show();
  }
});
document.addEventListener("DOMContentLoaded", function() {
  const notificationCountElement = document.getElementById("notification-count");
  const notificationList = document.getElementById("notification-list");
  const noNotificationElement = document.getElementById("no-notification");
  let notificationCount = notificationCountElement ? parseInt(notificationCountElement.getAttribute("data-count")) : 0;

  consumer.subscriptions.create({ channel: "RoomChannel" }, {
    connected() {
      console.log("Connected to the room!");
    },

    disconnected() {
    },

    received(data) {
      console.log("Receiving:");
      console.log(data.notification);

      notificationCount++;
      if (notificationCountElement) {
        notificationCountElement.setAttribute("data-count", notificationCount);
        notificationCountElement.textContent = notificationCount;
      }

      if (notificationCount === 1 && noNotificationElement) {
        noNotificationElement.style.display = "none";
      }

      if (notificationList) {
        // Create and append the new notification message
        const newNotification = document.createElement("li");
        newNotification.className = "notification-message ms-2 me-2 mt-3";
        newNotification.textContent = data.message;
        notificationList.appendChild(newNotification);

        // Create and append the "Mark as Read" button
        if (notificationCount === 1) {
          const markReadButton = document.createElement("button");
          markReadButton.className = "btn btn-sm btn-primary mark-read ms-1";
          markReadButton.textContent = "Mark all as read";
          markReadButton.addEventListener("click", markAllAsRead);
          notificationList.appendChild(markReadButton);
        }
      }
    }
  });
});
