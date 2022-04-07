import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import HomePage from 'src/pages/HomePage';
import ResearchPage from './src/pages/ResearchPage';
import CommunityPage from './src/pages/Solutions/CommunityPage';

const App = () => (
    <Router>
        <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/solutions/research" element={<ResearchPage />} />
            <Route path="/solutions/communities" element={<CommunityPage />} />
        </Routes>

    </Router>
);

export default App;
