import { ViewProps, requireNativeComponent } from 'react-native';

export interface RNCGalleryViewProps extends ViewProps {
  column: 3 | 4 | 5 | 6;
  mediaType: 'ALL' | 'PHOTO' | 'VIDEO';
}

export const RNCGalleryView =
  requireNativeComponent<RNCGalleryViewProps>('RNCGalleryView');
