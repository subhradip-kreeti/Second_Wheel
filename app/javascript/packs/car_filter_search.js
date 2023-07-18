console.log("car filter and search js loaded");
function filterCars() {
  var city = document.getElementById('city-select').value.trim();
  var brand = document.getElementById('brand-select').value;
  var model = document.getElementById('model-select').value;
  var regYear = document.getElementById('reg-year-select').value;
  console.log("car filter and search js")
  var variant = document.getElementById('variant-select').value;
  var regState = document.getElementById('reg-state-select').value;
  var kilometerDriven = document.getElementById('kilometer-driven-select').value;

  var cards = document.getElementsByClassName('card');
  for (var i = 0; i < cards.length; i++) {
    var card = cards[i];
    var shouldDisplay = true;

    if (city && card.querySelector('#city-name').textContent.trim() !== city) {
      console.log(city)
      console.log(card.querySelector('#city-name').textContent)
      shouldDisplay = false;
    }
    if (brand && card.querySelector('#brand-name').textContent !== brand) {
      shouldDisplay = false;
    }
    if (model && card.querySelector('#model-name').textContent !== model) {
      shouldDisplay = false;
    }
    if (regYear && card.querySelector('#reg-year').textContent !== regYear) {
      shouldDisplay = false;
    }
    if (variant && card.querySelector('#variant').textContent !== variant) {
      shouldDisplay = false;
    }
    if (regState && card.querySelector('#reg-state').textContent !== regState) {
      shouldDisplay = false;
    }
    if (kilometerDriven && card.querySelector('#km-driven').textContent !== kilometerDriven) {
      shouldDisplay = false;
    }

    card.style.display = shouldDisplay ? 'block' : 'none';
  }
}
