import axios from 'axios';

// Create an Axios instance with custom headers
const axiosInstance = axios.create({
  baseURL: 'https://ca516lrj4a.execute-api.ap-southeast-2.amazonaws.com/dev',
  
});

const sendMessage = async (message) => {
    try {
        const response = await axiosInstance.post('/example', {
            message: message
        });

        if (response.status === 200) {
            // Request successful, handle response
            console.log(response.data);
        } else {
            // Request failed, handle error
            throw new Error(`Failed to send message: ${response.statusText}`);
        }
    } catch (error) {
        console.error('Error sending message:', error.message);
        throw error;
    }
};

export default sendMessage;
