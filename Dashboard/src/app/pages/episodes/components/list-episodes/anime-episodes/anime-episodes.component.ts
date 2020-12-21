import { DatePipe } from '@angular/common';
import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnDestroy, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { HelperService } from 'src/app/@theme/helper/helper.service';
import { Animes } from 'src/app/pages/animes/entity/animes';
import { AnimesResponse } from 'src/app/pages/animes/entity/animes-response';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { AnimeEpisodes } from '../../../entity/anime-episodes';
import { AnimeEpisodesResponse } from '../../../entity/anime-episodes-response';
import { EpisodesService } from '../../../services/episodes.service';

@Component({
  selector: 'app-anime-episodes',
  templateUrl: './anime-episodes.component.html',
  providers: [DatePipe]
})
export class AnimeEpisodesComponent implements OnInit, OnDestroy {
  animes: Animes[];
  uploadForm: FormGroup;
  animeEpisodes: AnimeEpisodes[];
  animeEpisodesList: AnimeEpisodes[] = [];
  animeEpisodesFilterList: AnimeEpisodes[] = [];         // We Create It Second For Filter
  currentAnimeID: number;
  episodeDuration: any;
  isDeleted = false;
  config: any;                                          // Config Variable For Pagination Configuration
  name: string; 
  isClicked = false;
  animesSubscription: Subscription;

  constructor(private animeService: AnimeService, 
              private episodesService: EpisodesService,
              private formBuilder: FormBuilder,
              
              private datePipe: DatePipe,
              private toaster: ToastrService) { }

  ngOnInit() {

    // Get All Animes
    this.getAllAnimes();  
    this.uploadForm = this.formBuilder.group({
      animeID: ['']
    });
  }

  ngOnDestroy() {
    this.animesSubscription.unsubscribe();
  }

  // Get All Animes
  getAllAnimes() {
    this.animesSubscription = this.animeService.allAnimes().subscribe(
      (allAnimes: AnimesResponse) => this.animes = allAnimes.Data
    )
  }

  // get All Episodes For Specific Anime
  changeAnime(event) {
    this.isClicked = true;
    // this.currentAnimeID = event.target.value; 
    this.currentAnimeID =  Number(event) ? Number(event) : event.target.value; 
    console.log(this.currentAnimeID);
    this.episodesService.allAnimeEpisodes(this.currentAnimeID).subscribe(
      (animeEpisodes: AnimeEpisodesResponse) => {
        if (animeEpisodes) {
          this.animeEpisodes = animeEpisodes.Data;
          this.animeEpisodesList = animeEpisodes.Data;
          console.log(animeEpisodes);
        }
      },
      error => this.handleError(error),
      () => this.animeEpisodesFilterList = this.animeEpisodesList
    );

    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.animeEpisodesList.length
    };
  }

  // Handle Response Error
  handleError(error) {
    this.isClicked = false;
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  // Delete The Category
  delete(episodeID: number) {
    if (confirm('Are You Sure You Want To Delete This Episode')) {
      this.isDeleted = true;
      this.episodesService.deleteEpisode(episodeID).subscribe(
        data => {
          this.toaster.success('Episode Successfully Deleted');
          console.log('deleted Successfully: ', data);
        },
        error => {
          this.isDeleted = false;
          console.log('error : ', error);
          this.toaster.error('There Is An Error Please Try Again');
        }, () => {
          this.isDeleted = false;
        this.changeAnime(this.currentAnimeID);
        }
      );
    } else {
      return false;
    }
  }

  
  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.animeEpisodesFilterList = [...this.animeEpisodesList];
    } else {
      this.animeEpisodesFilterList = [];
      this.animeEpisodesFilterList = this.animeEpisodesList.filter(res => {
        // Search In Name Column
        const nameResult = res.animeName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
        // Search In Episode Number Column
        const episodeNumber = res.episodeNumber.toString().match(this.name.toLocaleLowerCase());
        // Search In Season Number Column
        const seasonNumber = res.seasonNumber.toString().match(this.name.toLocaleLowerCase());
        if (nameResult) {
          // display the Name Column
          return nameResult;
        } else if (episodeNumber) {
          // display the episodeNumber Column
          return episodeNumber;
        } else if (seasonNumber) {
          // display the seasonNumber Column
          return seasonNumber;
        }
      });
    }
  }

}
