var inputs = Array.from(document.querySelectorAll('input'));
const shuffleBtn = document.getElementById("shuffle");
const validateBtn = document.getElementById("validate");
const resetBtn = document.getElementById("reset");
const result = document.getElementById("result");

const dayInput = document.getElementById('day');
const monthInput = document.getElementById('month');
const yearInput = document.getElementById('year');

const positions = [0, 135, 270];

function suffle() {
    inputs.forEach(input => input.classList.add('shuffling'));
    const shuffledIndices = [0, 1, 2].sort(() => Math.random() - 0.5);
    setTimeout(() => {
        shuffledIndices.forEach((newIndex, currentIndex) => {
            inputs[currentIndex].style.left = positions[newIndex] + 'px';
        });

        setTimeout(() => {
            inputs.forEach(input => input.classList.remove('shuffling'));
        }, 600);
    }, 100);
}

shuffleBtn.addEventListener('click', () => {
    inputs.forEach(i => i.placeholder = "");
    shuffleBtn.disabled = true;
    const shuffleCount = 5;
    const delayBetweenShuffles = 700; 

    for (let i = 0; i < shuffleCount; i++) {
        setTimeout(() => {
            suffle();
            if (i === shuffleCount - 1) {
                setTimeout(() => {
                    shuffleBtn.disabled = false;
                }, 700);
            }
        }, i * delayBetweenShuffles);
    }

    shuffleBtn.classList.add('hidden');
    validateBtn.classList.remove('hidden');
    resetBtn.classList.remove('hidden');
    inputs.forEach(i => i.disabled = false);
});


resetBtn.addEventListener('click', () => {
    inputs.forEach(i => {
        i.disabled = true;
        i.placeholder = i.id;
        i.value = "";
    });
    shuffleBtn.classList.remove('hidden');
    validateBtn.classList.add('hidden');
    resetBtn.classList.add('hidden');
    result.innerHTML = "";
    result.classList.add('hidden');
    day.left = positions[0];
    month.left = positions[1];
    right.left = positions[2];
});

validateBtn.addEventListener('click', () => {
    let day = dayInput.value;
    let month = monthInput.value;
    let year = yearInput.value;

    if (result.classList.contains("hidden"))
        result.classList.remove("hidden");
    result.innerHTML = "You selected (day-month-year format): " + day + " / " + month + " / " + year;
});

