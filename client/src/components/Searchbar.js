import { useState } from 'react';
import './SearchBar.css';
import sendMessage from '../api'; 

function SearchBar({ onSubmit }) {
    const [message, setMessage] = useState('');

    const handleFormSubmit = async (event) => {
        event.preventDefault(); // Prevent the default form submission behavior
        try {
            await sendMessage(message);
            if (onSubmit) {
                onSubmit(message);
            }
        } catch (error) {
            // Handle any errors if needed
            console.error('Error sending message:', error.message);
        }
    };
    const handleChange = (event) => {
        setMessage(event.target.value); // Update the message as the user types
    };

    return (
        <div className='search-bar'>
            <form onSubmit={handleFormSubmit}>
                <h2>Enter Message</h2>
                <textarea value={message} onChange={handleChange} rows="4" cols="50" />
                <button className="btn-1 b1" type="submit">Submit</button>
            </form>
        </div>
    );
}

export default SearchBar;
