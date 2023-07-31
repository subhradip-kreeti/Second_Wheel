window.updateAppointmentStatus = function(appointmentId) {
  const selectElement = document.getElementById(
    `appointment-status-select-${appointmentId}`
  );
  const newStatus = selectElement.value;
  const currentStatusElement = document.getElementById(
    `appointment-status-${appointmentId}`
  );
  const currentStatus = currentStatusElement.innerText;
  const regnoElement = document.getElementById(`reg-no-${appointmentId}`);
  const regNo = regnoElement.innerText;

  if (!isValidStatusTransition(currentStatus, newStatus)) {
    alert("Invalid status transition");
    return;
  }

  $.ajax({
    url: `/appointments/status_update/${appointmentId}`,
    method: "POST",
    data: {
      status: newStatus,
      reg_no: regNo,
      id: appointmentId,
      authenticity_token: $('meta[name="csrf-token"]').attr("content"),
    },
    success: function (response) {
      currentStatusElement.innerText = newStatus;
      alert("Appointment status updated successfully");
    },
    error: function (xhr, status, error) {
      console.error("Request failed");
    },
  });
}

function isValidStatusTransition(currentStatus, newStatus) {
  if (!currentStatus || !newStatus) {
    return false;
  }

  const validTransitions = {
    Sell_Pending: ["Sell_Processing", "Reject"],
    Sell_Processing: ["Sell_Investigating", "Reject"],
    Sell_Investigating: ["Ready_for_Sell", "Reject"],
    Ready_for_Sell: ["Sold", "Reject"],
    Sold: [],
    Reject: [],
    Buy_Pending: ["Buy_Processing", "Buy_Request_Cancelled"],
    Buy_Processing: ["Buy_Investigating", "Buy_Request_Cancelled"],
    Buy_Investigating: ["Ready_to_Buy", "Buy_Request_Cancelled"],
    Ready_to_Buy: ["Bought", "Buy_Request_Cancelled"],
    Bought: [],
    Buy_Request_Cancelled: [],
  };

  return validTransitions[currentStatus].includes(newStatus);
}

window.applyFilters = function() {
  const roleFilter = document.getElementById("roleFilter").value;
  const statusFilter = document.getElementById("statusFilter").value;
  const appointments = document.getElementsByClassName("card");

  switch (statusFilter) {
    case "pending":
      var statusFilter1 = "Buy_Pending";
      var statusFilter2 = "Sell_Pending";
      break;
    case "processing":
      var statusFilter1 = "Buy_Processing";
      var statusFilter2 = "Sell_Processing";
      break;
    case "investigating":
      var statusFilter1 = "Buy_Investigating";
      var statusFilter2 = "Sell_Investigating";
      break;
    case "ready_for_sell":
      var statusFilter1 = "Ready_to_Buy";
      var statusFilter2 = "Ready_for_Sell";
      break;
    case "sold":
      var statusFilter1 = "Bought";
      var statusFilter2 = "Sold";
      break;
    case "reject":
      var statusFilter1 = "Buy_Request_Cancelled";
      var statusFilter2 = "Reject";
      break;
    default:
      var statusFilter1 = "";
      var statusFilter2 = "";
      break;
  }

  for (let i = 0; i < appointments.length; i++) {
    const appointment = appointments[i];
    const role = appointment.getAttribute("data-role");
    const status = appointment.getAttribute("data-status");

    if (roleFilter && role !== roleFilter) {
      appointment.style.display = "none";
    } else if (
      statusFilter &&
      status !== statusFilter &&
      status !== statusFilter1 &&
      status !== statusFilter2
    ) {
      appointment.style.display = "none";
    } else {
      appointment.style.display = "block";
    }
  }
}

applyFilters();

window.changeSortOption = function(sortOption) {
  const appointmentsContainer = document.querySelector(".row.mt-4");
  const appointments = Array.from(
    appointmentsContainer.getElementsByClassName("card")
  );

  appointments.sort((a, b) => {
    const aStatus = a.getAttribute("data-status");
    const bStatus = b.getAttribute("data-status");
    const aRole = a.getAttribute("data-role");
    const bRole = b.getAttribute("data-role");
    const aCarBrand = a.getAttribute("data-car-brand");
    const bCarBrand = b.getAttribute("data-car-brand");
    const aCarModel = a.getAttribute("data-car-model");
    const bCarModel = b.getAttribute("data-car-model");
    const aCreatedDate = a.getAttribute("data-created-date");
    const bCreatedDate = b.getAttribute("data-created-date");
    const aAppointmentDate = a.getAttribute("data-appointment-date");
    const bAppointmentDate = b.getAttribute("data-appointment-date");

    const compareValues = (valueA, valueB) => {
      if (valueA < valueB) return -1;
      if (valueA > valueB) return 1;
      return 0;
    };

    function compareDates(dateA, dateB) {
      const timestampA = new Date(
        dateA.substring(0, 4),
        parseInt(dateA.substring(4, 6)) - 1,
        dateA.substring(6, 8),
        dateA.substring(8, 10),
        dateA.substring(10, 12),
        dateA.substring(12, 14)
      ).getTime();
      const timestampB = new Date(
        dateB.substring(0, 4),
        parseInt(dateB.substring(4, 6)) - 1,
        dateB.substring(6, 8),
        dateB.substring(8, 10),
        dateB.substring(10, 12),
        dateB.substring(12, 14)
      ).getTime();
      return timestampB - timestampA;
    }

    const statusOrder = [
      "Sell_Pending",
      "Buy_Pending",
      "Sell_Processing",
      "Buy_Processing",
      "Sell_Investigating",
      "Buy_Investigating",
      "Ready_for_Sell",
      "Ready_to_Buy",
      "Sold",
      "Bought",
      "Reject",
      "Buy_Request_Cancelled",
    ];
    switch (sortOption) {
      case "status-asc":
        return (
          compareValues(
            statusOrder.indexOf(aStatus),
            statusOrder.indexOf(bStatus)
          ) ||
          compareValues(aRole, bRole) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate)
        );

      case "status-desc":
        return (
          compareValues(
            statusOrder.indexOf(bStatus),
            statusOrder.indexOf(aStatus)
          ) ||
          compareValues(aRole, bRole) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate)
        );

      case "role-asc":
        return (
          compareValues(aRole, bRole) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "role-desc":
        return (
          compareValues(bRole, aRole) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "car-brand-asc":
        return (
          compareValues(aCarBrand, bCarBrand) ||
          compareValues(aCarModel, bCarModel) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "car-brand-desc":
        return (
          compareValues(bCarBrand, aCarBrand) ||
          compareValues(aCarModel, bCarModel) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "car-model-asc":
        return (
          compareValues(aCarModel, bCarModel) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "car-model-desc":
        return (
          compareValues(bCarModel, aCarModel) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "date-created-asc":
        return (
          compareDates(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "date-created-desc":
        return (
          compareDates(bCreatedDate, aCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "appointment-date-asc":
        return (
          compareDates(aAppointmentDate, bAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      case "appointment-date-desc":
        return (
          compareDates(bAppointmentDate, aAppointmentDate) ||
          compareValues(aStatus, bStatus)
        );

      default:
        return (
          compareValues(aStatus, bStatus) ||
          compareValues(aRole, bRole) ||
          compareValues(aCreatedDate, bCreatedDate) ||
          compareValues(aAppointmentDate, bAppointmentDate)
        );
    }
  });

  appointmentsContainer.innerHTML = "";
  appointments.forEach((appointment) =>
    appointmentsContainer.appendChild(appointment)
  );
}
