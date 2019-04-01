import {h,render} from 'preact';
import Msgbox from '../components/msgbox/msgbox.js';
import Toast from '../components/toast/toast.js';
render(
  <Msgbox/>,
  document.body
);
render(
  <Toast/>,
  document.body
);