const SET_COLOR_DARK = 'SET_COLOR_DARK';
const SET_COLOR_LIGHT = 'SET_COLOR_LIGHT';

export const darkMode = (theme) => {
    return {
        type: SET_COLOR_DARK,
        theme
    };
};

export const lightMode = (theme) => {
    return {
        type: SET_COLOR_LIGHT,
        theme
    };
};