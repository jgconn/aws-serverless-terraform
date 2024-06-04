import React, { useState } from 'react';
import axios from 'axios';
import './SearchBar.css';

// Create an Axios instance with custom headers
const axiosInstance = axios.create({
  baseURL: 'https://ca516lrj4a.execute-api.ap-southeast-2.amazonaws.com/dev',
});

function MessageList() {
    const [messageValues, setMessageValues] = useState([]);
    const [showMessages, setShowMessages] = useState(true);

    const fetchMessages = async () => {
        try {
            const response = await axiosInstance.get('/example');
            if (response.data && response.data.body) {
                const responseObj = JSON.parse(response.data.body);
                const messages = responseObj.messages;
                const messageValues = messages.map(item => item.message);
                setMessageValues(messageValues); // Update the state with message values
                console.log(messageValues);
                setShowMessages(true); // Show messages after fetching
            } else {
                console.error('Error fetching messages: Messages array not found in response');
            }
        } catch (error) {
            console.error('Error fetching messages:', error);
        }
    };

    const handleGetMessages = () => {
        fetchMessages(); 
    };

    const handleHideMessages = () => {
        setShowMessages(false); 
    };
    
    return (
        <div>
            <h2>Message List</h2>
            <button className='btn-1' onClick={handleGetMessages}>Get Messages</button>
            {showMessages && (
                <ul>
                    {messageValues.map((message, index) => (
                        <li key={index}>{message}</li>
                    ))}
                </ul>
            )}
            <button className='btn-1' onClick={handleHideMessages}>Hide Messages</button>
        </div>
    );
}

export default MessageList;
