import consumer from "./consumer";

document.addEventListener("DOMContentLoaded", function() {
  consumer.subscriptions.create({ channel: "RoomChannel" }, {
    connected() {
      console.log("Connected to the room!");
    },

    disconnected() {
    },

    received(data) {
      console.log("Receiving:");
      console.log(data.notification);

      var notificationCountElement = document.getElementById("notification-count");
      var notificationCount = notificationCountElement ? parseInt(notificationCountElement.getAttribute("data-count")) : 0;

      notificationCount++;
      if (notificationCountElement) {
        notificationCountElement.setAttribute("data-count", notificationCount);
        notificationCountElement.textContent = notificationCount;
      }

      var notificationList = document.getElementById("notification-list");
      var noNotificationElement = document.getElementById("no-notification");

      if (noNotificationElement) {
        noNotificationElement.style.display = "none";
      }

      if (!notificationList) {
        // Create the notification-list element
        notificationList = document.createElement("ul");
        notificationList.id = "notification-list";
        notificationList.className = "dropdown-menu";

        // Append the notification-list element to the existing DOM structure
        var dropdownMenu = document.getElementById("dropdownMenuLink");
        dropdownMenu.appendChild(notificationList);
      }

      var newNotification = document.createElement("li");
      newNotification.className = "notification-message";
      newNotification.className = "notification-message ms-2 me-2 mt-3";
      newNotification.textContent = data.message;
      notificationList.appendChild(newNotification);
    }
  });
});
