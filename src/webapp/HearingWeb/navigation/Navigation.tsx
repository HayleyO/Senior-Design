
import { Pages } from "./Pages";

export function headerTabOnClick(event, page) {
        switch(page){
            case Pages.home:
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