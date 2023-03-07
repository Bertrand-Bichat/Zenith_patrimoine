// External imports
import "bootstrap";

// Internal imports
import "controllers"
import flatpickr from "flatpickr";
import FlatpickrI18n from 'flatpickr/dist/l10n/fr.js';
import { topArrow, scrollFunction, topFunction } from '../components/top_arrow';


document.addEventListener('turbolinks:load', () => {
  // flèche pour scroll jusqu'en haut (toutes les pages)
  topArrow();

  // flatpicker for datetime input
  flatpickr.localize(FlatpickrI18n.fr);
  flatpickr(".date-input", {
      minDate: "today",
      // maxDate: new Date().fp_incr(XX), // XX days from now
      enableTime: false,
      dateFormat: "d/m/Y",
      time_24hr: true,
      // minTime: "08:00",
      // maxTime: "23:00",
      // minuteIncrement: 15,
      "locale": {
          "firstDayOfWeek": 1 // start week on Monday
      }
      // onClose: keepMinutesToZero()
  });
});
