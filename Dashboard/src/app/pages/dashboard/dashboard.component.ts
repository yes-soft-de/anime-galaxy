import { DatePipe, formatDate } from '@angular/common';
import { typeWithParameters } from '@angular/compiler/src/render3/util';
import { Component, OnDestroy, OnInit } from '@angular/core';
import {forkJoin, Observable, Subscription} from 'rxjs';
import { map, mergeMap } from 'rxjs/operators';
import { FooterComponent } from 'src/app/@theme/components';
import { AnimesResponse } from '../animes/entity/animes-response';
import { AnimeService } from '../animes/services/anime.service';
import { ListCategoryResponse } from '../categories/entity/list-category-response';
import { CategoryService } from '../categories/services/category.service';
import { EpisodeComingSoonResponse } from '../episodes/entity/episode-coming-soon-response';
import { EpisodeComingSoon } from '../episodes/entity/episode-coming-soone';
import { EpisodesService } from '../episodes/services/episodes.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
  providers: [FooterComponent]
})
export class DashboardComponent implements OnInit, OnDestroy {
  mergeResult: {
    categories: ListCategoryResponse,
    animes: AnimesResponse
  }
  // categories: ListCategory[];
  // animes: Animes[];
  episodeComingSoon: EpisodeComingSoon[];
  // statues: {0: StatueInterface, price: string}[];
  
  latestCategoriesNumber = 5;
  latestAnimesNumber = 5;
  latestEpisodesComingSoonNumber = 5;
  
  combinedObservable: Subscription;

  constructor(private categoryService: CategoryService,
              private animeService: AnimeService,
              private episodesService: EpisodesService) {
  }

  ngOnInit() {
      
    const allcategories: Observable<ListCategoryResponse> = this.categoryService.allCategories();
    const allAnimes: Observable<AnimesResponse> = this.animeService.allAnimes();
    const allEpisodesComingSoon: Observable<EpisodeComingSoonResponse> = this.episodesService.allEpisodesComingSoon();
    
    const mergeRequests: Observable<any> = allcategories.pipe(
      mergeMap(categoriesResponse => {
        return allAnimes.pipe(
          map(animesResponse => {
            const result = {
              categories: categoriesResponse,
              animes: animesResponse
            }
            return result;
          })
        )
      })
    );
    mergeRequests.subscribe(data => {
      this.mergeResult = data;
    });
    allEpisodesComingSoon.subscribe(
      episodesComingSoonReponse => {
        if (episodesComingSoonReponse) {
          this.episodeComingSoon = episodesComingSoonReponse.Data;
        }
      }, error => {
        console.log('episodesComingSoonReponse : ', error);
      }
    );
  }

  ngOnDestroy() {
    // this.combinedObservable.unsubscribe();
  }

}
