import { requireNativeComponent } from 'react-native';

interface RNCGalleryViewProps {}

export const RNCGalleryView =
  requireNativeComponent<RNCGalleryViewProps>('RNCGalleryView');
