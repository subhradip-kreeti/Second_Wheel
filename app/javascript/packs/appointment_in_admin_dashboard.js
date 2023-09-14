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
