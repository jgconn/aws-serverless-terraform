import React, { useState } from 'react';
import SearchBar from './components/Searchbar';
import MessageList from './components/Messagelist'; // Import the MessageList component

function App() {
    const [images, setImages] = useState([]);

    const handleSubmit = async (term) => {
        // Logic to handle form submission
    };

    return (
        <div className="app-container">
            <div className="form-container">
                <SearchBar onSubmit={handleSubmit} />
                <MessageList />
            </div>
        </div>
    );
}

export default App;

