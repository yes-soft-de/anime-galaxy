import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { SuggestRoutingModule } from './suggest-routing.module';

import { SuggestComponent } from './suggest.component';
import { EditSuggestComponent } from './components/edit-suggest/edit-suggest.component';
import { HightestRatedAnimeComponent } from './components/hightest-rated-anime/hightest-rated-anime.component';


@NgModule({
  declarations: [SuggestComponent, EditSuggestComponent, HightestRatedAnimeComponent],
  imports: [
    ThemeModule,
    SuggestRoutingModule
  ]
})
export class SuggestModule { }
