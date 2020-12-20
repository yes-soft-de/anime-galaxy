import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Subscription } from 'rxjs';
import { Animes } from 'src/app/pages/animes/entity/animes';
import { AnimesResponse } from 'src/app/pages/animes/entity/animes-response';
import { AnimeService } from 'src/app/pages/animes/services/anime.service';
import { AnimeEpisodes } from '../../../entity/anime-episodes';
import { AnimeEpisodesResponse } from '../../../entity/anime-episodes-response';
import { EpisodesService } from '../../../services/episodes.service';

@Component({
  selector: 'app-season-episodes',
  templateUrl: './season-episodes.component.html'
})
export class SeasonEpisodesComponent implements OnInit {
  animes: Animes[];
  sessions = ['Season One', 'Season Two', 'Season Three', 'Season Four', 'Season Five', 'Season Six', 'Season Seven', 'Season Eight', 'Season Nine', 'Season Ten'];
  uploadForm: FormGroup;
  animeSeasonEpisodes: AnimeEpisodes[];
  animeSeasonEpisodesList: AnimeEpisodes[] = [];
  animeSeasonEpisodesFilterList: AnimeEpisodes[] = [];         // We Create It Second For Filter
  currentSubmitData: {
    animeID: number, 
    season: number
  };
  isSubmitted = false;
  isDeleted = false;
  config: any;                                                // Config Variable For Pagination Configuration
  name: string;
  isClicked = false;
  animesSubscription: Subscription;

  constructor(private animeService: AnimeService, 
              private episodesService: EpisodesService,
              private formBuilder: FormBuilder,
              private toaster: ToastrService) { }

  ngOnInit() {
    // Get All Animes
    this.getAllAnimes();  

    this.uploadForm = this.formBuilder.group({
      animeID: [''],
      season: ['']
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
    this.uploadForm.patchValue(event.target.value, {
      onlySelf: true
    });
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
          this.mySubmit();
        }
      );
    } else {
      return false;
    }
  }


  mySubmit() {
    this.isClicked = true;
    this.isSubmitted = true;
    if (!this.uploadForm.valid) {
      this.toaster.error('Error : Form Not Valid');
      return false;
    } else {
      const formObject = this.uploadForm.getRawValue();
      this.currentSubmitData = formObject;
      console.log(formObject, this.currentSubmitData);
      this.episodesService.allAnimeSeasonEpisodes(formObject.animeID, formObject.season).subscribe(
        (animeSeasonEpisodes: AnimeEpisodesResponse) => {
          if (animeSeasonEpisodes) {
            this.isSubmitted = false;
            this.animeSeasonEpisodes = animeSeasonEpisodes.Data;
            this.animeSeasonEpisodesList = animeSeasonEpisodes.Data;
          }
        },
        error => {
          this.isSubmitted = false;
          this.handleError(error);
        },
        () => this.animeSeasonEpisodesFilterList = this.animeSeasonEpisodesList
      );

      this.config = {
        itemsPerPage: 5,
        currentPage: 1,
        totalItems: this.animeSeasonEpisodesList.length
      };
    }
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
  
  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.animeSeasonEpisodesFilterList = [...this.animeSeasonEpisodesList];
    } else {
      this.animeSeasonEpisodesFilterList = [];
      this.animeSeasonEpisodesFilterList = this.animeSeasonEpisodesList.filter(res => {
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
