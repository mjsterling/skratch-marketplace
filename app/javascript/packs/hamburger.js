const state = {
    hamburger: false,
}

function toggleHamburger() {
    const menu = document.getElementById("hamburgerMenu");
    if (state.hamburger) {
        menu.style.display = "none";
    } else {
        menu.style.display = "flex";
    }
    state.hamburger = !state.hamburger
}