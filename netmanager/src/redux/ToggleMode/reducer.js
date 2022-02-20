const initialState = {
    theme: localStorage.getItem('colortheme')
}

export default function (state = initialState, action) {
    switch (action.type) {
        case 'SET_COLOR_DARK':
            return [
                {
                    ...state,
                    theme: localStorage.setItem('colortheme', 'dark')
                },
                document.documentElement.setAttribute('data-theme', 'dark')]
        case 'SET_COLOR_LIGHT':
            return [
                {
                    ...state,
                    theme: localStorage.setItem('colortheme', 'light')
                },
                document.documentElement.setAttribute('data-theme', 'light')]
        default:
            return state;
    }
}