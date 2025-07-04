console.log("Hello world");


/* Pomodoro */

let time_left = 25 * 60; //set pomodoro duration in seconds
let is_running = false; //true if pomodoro timer is active
let is_work_session = true //begin with a work session
//get buttons
let start_btn = document.getElementById('start_pomo');
let pause_btn = document.getElementById('pause_pomo');
let stop_btn = document.getElementById('stop_pomo');
let pomo_display = document.getElementById('pomo_timer');
let pomo_state = document.getElementById('pomo_state');
let timer_interval;

//basics pomodoro functions
function update_pomo() {
  let minutes = Math.floor(time_left / 60); 
  let seconds = time_left % 60; 
  //display timer on html div
  pomo_display.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`; 
}

function start_pomo() {
  if (!is_running) {

    if (is_work_session) {
      pomo_state.textContent = "Working";
    } else {
      pomo_state.textContent = "Break";
    }

    if (time_left <= 0) {
      if (!is_work_session) {
        time_left = 5 * 60;
      } else {
        time_left = 25 * 60;
      }
      
    }

    is_running = true;
    timer_interval = setInterval(() => {
      if (time_left > 0) {
        time_left--;
        update_pomo();
      } else {
        clearInterval(timer_interval);
        if (is_work_session) {
          is_work_session = false
        } else {
          is_work_session = true;
        }

        is_running = false;
        start_pomo();
      }
    }, 1000);
  }
}

function pause_pomo() {
  clearInterval(timer_interval);
  pomo_state.textContent = "Paused";
  is_running = false;
}

function stop_pomo() {
  clearInterval(timer_interval);
  pomo_state.textContent = "Stopped";
  is_running = false;
  time_left = 25 * 60;
  update_pomo();
}

start_btn.addEventListener('click', start_pomo);
pause_btn.addEventListener('click', pause_pomo);
stop_btn.addEventListener('click', stop_pomo);

/* CLock and date */
const weekday = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];

//update clock (every seconds)
function updateTime() {
  let now = new Date();
  let hours = now.getHours();
  let minutes = now.getMinutes();
  let day = weekday[now.getDay()];
  let day_number = now.getDate();

  if (hours < 10) hours = "0" + hours;
  if (minutes < 10) minutes = "0" + minutes;
    
  document.getElementById("clock_content").textContent = `${hours}:${minutes}`;
  document.getElementById("date_content").textContent = `${day} ${day_number}`;
}

setInterval(updateTime, 1000);
updateTime(); //update first (else we need to wait 1 seconds)
