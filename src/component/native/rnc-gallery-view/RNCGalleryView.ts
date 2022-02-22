import { ViewProps, requireNativeComponent } from 'react-native';

export interface RNCGalleryViewProps extends ViewProps {}

export const RNCGalleryView =
  requireNativeComponent<RNCGalleryViewProps>('RNCGalleryView');
