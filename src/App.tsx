import React from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';

const App: React.FC = () => {
    return (
        <Router>
            <div>
                <header>
                    <h1>My App</h1>
                </header>
                <main>
                    <Switch>
                        <Route path="/" exact>
                            <h2>Home Page</h2>
                        </Route>
                        {/* Add more routes here */}
                    </Switch>
                </main>
                <footer>
                    <p>Footer content here</p>
                </footer>
            </div>
        </Router>
    );
};

export default App;