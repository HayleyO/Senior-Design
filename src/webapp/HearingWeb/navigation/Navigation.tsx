import {useNavigate} from "react-router-dom"
import { Pages } from "./Pages";

export function headerTabOnClick(event, page) {
    const navigate = useNavigate();
        switch(page){
            case Pages.home:
                navigate('/');
                break;
            case Pages.about:
                break;
            case Pages.how_to:
                break;
            case Pages.settings:
                break;
        }
        event.stopPropagation();
        
    }