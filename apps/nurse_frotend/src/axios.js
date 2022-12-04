import axios from 'axios';
// Next we make an 'instance' of it
const instance = axios.create({
    // .. where we make our configurations
    baseURL: 'http://192.168.0.2:10002/api/v1'
});

// Where you would set stuff like your 'Authorization' header, etc ...
instance.defaults.headers.common['Authorization'] = localStorage.getItem("token") || "";
instance.interceptors.response.use((response) => {
    return response
}, (error) => {
    if (error.response.status == 401) {
        window.location.pathname = "/login"
    }
    return Promise.reject(error);
}
)
export default instance;